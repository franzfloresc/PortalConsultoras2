use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go

  use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go


use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Getpedidowebbyfechafacturacion_sinmarcar_sb2]
GO
/*             
CREADO POR  : PAQUIRRI SEPERAK             
FECHA : 24/06/2019             
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS      
*/ 
CREATE PROCEDURE [DBO].[Getpedidowebbyfechafacturacion_sinmarcar_sb2] 
  -- '2015-10-19',1  
  @CAMPANAID        INT,--=201909  
  @TIPOCRONOGRAMA   INT,--=1  
  @NROLOTE          INT--=22  
  , 
  @FECHAFACTURACION DATE 
WITH RECOMPILE 
AS 
  BEGIN 
      SET NOCOUNT ON; 

      DECLARE @TIPO SMALLINT 
      DECLARE @ESQUEMADACONSULTORA BIT 

      SET @TIPO = (SELECT ISNULL(PROCESOREGULAR, 0) 
                   FROM   [DBO].[CONFIGURACIONVALIDACION]) 

      SELECT @ESQUEMADACONSULTORA = ESQUEMADACONSULTORA 
      FROM   PAIS WITH(NOLOCK) 
      WHERE  ESTADOACTIVO = 1 

      DECLARE @CONFVALZONATEMP TABLE 
        ( 
           CAMPANIAID             INT, 
           REGIONID               INT, 
           ZONAID                 INT, 
           FECHAINICIOFACTURACION SMALLDATETIME, 
           FECHAFINFACTURACION    SMALLDATETIME, 
           CODIGOREGION           VARCHAR(8), 
           CODIGOZONA             VARCHAR(8), 
           CODIGOCAMPANIA         INT 
        ) 
      DECLARE @TABLA_PEDIDO_DETALLE TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT, 
           CUV                          VARCHAR(20) NULL, 
           CANTIDAD                     INT NULL, 
           PEDIDODETALLEIDPADRE         BIT 
        ) 
      DECLARE @TABLA_PEDIDO TABLE 
        ( 
           CAMPANIAID                   INT NULL, 
           PEDIDOID                     INT NULL, 
           CLIENTES                     INT, 
           ESTADOPEDIDO                 SMALLINT NULL, 
           VALIDACIONABIERTA            BIT NULL, 
           BLOQUEADO                    BIT NULL, 
           INDICADORENVIADO             BIT NULL, 
           MODIFICAPEDIDORESERVADOMOVIL BIT NULL, 
           CODIGOCONSULTORA             VARCHAR(25) NULL, 
           CODIGOREGION                 VARCHAR(8) NULL, 
           CODIGOZONA                   VARCHAR(8) NULL, 
           CAMPANIAIDSICC               INT NULL, 
           ZONAID                       INT 
        ) 

      /*SOLO VÁLIDO CUANDO EL TIPO DE PROGRAMA ES 1=REGULAR*/ 
      INSERT INTO @CONFVALZONATEMP 
      SELECT CR.CAMPANIAID, 
             CR.REGIONID, 
             CR.ZONAID, 
             CR.FECHAINICIOFACTURACION, 
             CR.FECHAINICIOFACTURACION 
             + ISNULL(CZ.DIASDURACIONCRONOGRAMA, 1) - 1 + ISNULL( 
             DBO.GETHORASDURACIONRESTRICCION(CR.ZONAID, 
             CZ.DIASDURACIONCRONOGRAMA, 
                    CR.FECHAINICIOFACTURACION), 0), 
             R.CODIGO, 
             Z.CODIGO, 
             CAST(CA.CODIGO AS INT) 
      FROM   ODS.CRONOGRAMA CR WITH(NOLOCK) 
             LEFT JOIN CONFIGURACIONVALIDACIONZONA CZ WITH(NOLOCK) 
                    ON CR.ZONAID = CZ.ZONAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON CR.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON CR.ZONAID = Z.ZONAID 
             INNER JOIN ODS.CAMPANIA CA WITH(NOLOCK) 
                     ON CR.CAMPANIAID = CA.CAMPANIAID 
             LEFT JOIN CRONOGRAMA CO WITH(NOLOCK) 
                    ON CR.CAMPANIAID = CO.CAMPANIAID 
                       AND CR.ZONAID = CO.ZONAID 
      WHERE  CA.CODIGO = @CAMPANAID 
             AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
             AND CR.FECHAINICIOFACTURACION + 10 >= @FECHAFACTURACION 
             AND IIF(ISNULL(CO.ZONAID, 0) = 0, 1, 
                 IIF(@ESQUEMADACONSULTORA = 0, 0, 
                 1)) 
                 = 1 

      -- SELECT * FROM @CONFVALZONATEMP  
      IF @ESQUEMADACONSULTORA = 0 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
        END 
      ELSE 
        BEGIN 
            INSERT INTO @TABLA_PEDIDO_DETALLE 
            SELECT P.CAMPANIAID, 
                   P.PEDIDOID, 
                   P.CLIENTES, 
                   P.ESTADOPEDIDO, 
                   P.VALIDACIONABIERTA, 
                   P.BLOQUEADO, 
                   P.INDICADORENVIADO, 
                   P.MODIFICAPEDIDORESERVADOMOVIL, 
                   C.CODIGO, 
                   CR.CODIGOREGION, 
                   CR.CODIGOZONA, 
                   CR.CAMPANIAID, 
                   CR.ZONAID, 
                   PD.CUV, 
                   PD.CANTIDAD, 
                   IIF(PD.PEDIDODETALLEIDPADRE IS NULL, 0, 1) 
            FROM   DBO.PEDIDOWEB P WITH(NOLOCK) 
                   JOIN DBO.PEDIDOWEBDETALLE PD WITH(NOLOCK) 
                     ON PD.CAMPANIAID = P.CAMPANIAID 
                        AND PD.PEDIDOID = P.PEDIDOID 
                   JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON P.CONSULTORAID = C.CONSULTORAID 
                   JOIN @CONFVALZONATEMP CR 
                     ON P.CAMPANIAID = CR.CODIGOCAMPANIA 
                        AND C.REGIONID = CR.REGIONID 
                        AND C.ZONAID = CR.ZONAID 
                   LEFT JOIN CONFIGURACIONCONSULTORADA DA WITH(NOLOCK) 
                          ON P.CAMPANIAID = DA.CAMPANIAID 
                             AND P.CONSULTORAID = DA.CONSULTORAID 
            WHERE  P.CAMPANIAID = @CAMPANAID 
                   AND CR.FECHAINICIOFACTURACION <= @FECHAFACTURACION 
                   AND CR.FECHAFINFACTURACION >= @FECHAFACTURACION 
                   AND ISNULL(DA.TIPOCONFIGURACION, 0) = 0 
        END 

      INSERT INTO @TABLA_PEDIDO 
      SELECT CAMPANIAID, 
             PEDIDOID, 
             CLIENTES, 
             ESTADOPEDIDO, 
             VALIDACIONABIERTA, 
             BLOQUEADO, 
             INDICADORENVIADO, 
             MODIFICAPEDIDORESERVADOMOVIL, 
             CODIGOCONSULTORA, 
             CODIGOREGION, 
             CODIGOZONA, 
             CAMPANIAIDSICC, 
             ZONAID 
      FROM   @TABLA_PEDIDO_DETALLE 
      WHERE 
        -- INDICADORENVIADO = 0  
        -- BLOQUEADO = 0  
        ( @TIPO = 0 
           OR @TIPO = IIF(ESTADOPEDIDO = 202 
                          AND VALIDACIONABIERTA = 0, 202, 201) ) 
      GROUP  BY CAMPANIAID, 
                PEDIDOID, 
                CLIENTES, 
                ESTADOPEDIDO, 
                VALIDACIONABIERTA, 
                BLOQUEADO, 
                INDICADORENVIADO, 
                MODIFICAPEDIDORESERVADOMOVIL, 
                CODIGOCONSULTORA, 
                CODIGOREGION, 
                CODIGOZONA, 
                CAMPANIAIDSICC, 
                ZONAID 

      -- ORDER BY  
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CLIENTES, 
             P.CODIGOREGION, 
             P.CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO 
      FROM   @TABLA_PEDIDO P 

      -- WHERE PEDIDOID=9728014 
      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             P.CODIGOCONSULTORA, 
             P.CUV             AS CODIGOVENTA, 
             PR.CODIGOPRODUCTO AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD)   AS CANTIDAD 
      FROM   @TABLA_PEDIDO_DETALLE P 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) 
                     ON P.CAMPANIAIDSICC = PR.CAMPANIAID 
                        AND P.CUV = PR.CUV 
      WHERE  P.PEDIDODETALLEIDPADRE = 0 
      --AND PEDIDOID=9728014 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                P.CODIGOCONSULTORA, 
                P.CUV, 
                PR.CODIGOPRODUCTO 
      HAVING SUM(P.CANTIDAD) > 0; 
  END
  go
