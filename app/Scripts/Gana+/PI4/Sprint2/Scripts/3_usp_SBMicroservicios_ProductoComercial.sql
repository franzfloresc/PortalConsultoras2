USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL'))
Begin
	Drop PROC USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
End
GO  

CREATE PROCEDURE dbo.USP_SBMICROSERVICIOS_PRODUCTOCOMERCIAL
AS
  BEGIN
      SET nocount ON

      DECLARE @cteCampanias TABLE
        (
           CAMPANIAID INT
        )

      INSERT INTO @cteCampanias
      SELECT DISTINCT TOP 8 CAMPANIAID
      FROM   ods.productocomercial PM WITH(nolock)
      ORDER  BY 1 DESC

      CREATE TABLE #productotemporal
        (
           CAMPANIAID           INT,
           CODIGOCAMPANIA       INT,
           CUV                  VARCHAR(50),
           DESCRIPCIONCUV       VARCHAR(100),
           CODIGOPRODUCTO       VARCHAR(10),
           PRECIOUNITARIO       NUMERIC(12, 2),
           INDICADORPREUNI      NUMERIC(12, 2),
           PRECIOPUBLICO        NUMERIC(12, 2),
           PRECIOOFERTA         NUMERIC(12, 2),
           PRECIOTACHADO        NUMERIC(12, 2),
           GANANCIA             NUMERIC(12, 2),
           INDICADORMONTOMINIMO INT,
           INDICADORDIGITABLE   INT,
           ESTRATEGIAIDSICC     INT,
           CODIGOOFERTA         INT,
           NUMEROGRUPO          INT,
           NUMERONIVEL          INT,
           MARCAID              INT,
           MARCADESCRIPCION     VARCHAR(50),
           IDMATRIZCOMERCIAL    INT,
           IMAGENURL            VARCHAR(150),
           NIVELES              VARCHAR(200),
           CODIGOCATALOGO       VARCHAR(6),
           CATEGORIA            VARCHAR(200),
           GRUPOARTICULO        VARCHAR(200),
           LINEA                VARCHAR(200),
           PRECIOCATALOGO       NUMERIC(12, 2),
           PRECIOVALORIZADO     NUMERIC(12, 2),
           FACTORREPETICION     INT,
           CODIGOTIPOOFERTA     VARCHAR(6)
        )

      INSERT INTO #productotemporal
      SELECT p.CAMPANIAID,
             p.ANOCAMPANIA,
             p.CUV,
             Replace(COALESCE(mci.DESCRIPCIONCOMERCIAL,
             pd.DESCRIPCION, p.DESCRIPCION), '"', Char(39)) AS DescripcionCUV,
             p.CODIGOPRODUCTO,
             p.PRECIOUNITARIO,
             p.INDICADORPREUNI,
             p.MONTOTOTALCATALOGO,--0, PrecioPublico
             p.MONTOTOTALCATALOGO,--0, PrecioOferta
             p.MONTOTOTALPUBLICO,--0, PrecioTachado
             p.GANANCIATOTAL,--0, Ganancia
             p.INDICADORMONTOMINIMO,
             p.INDICADORDIGITABLE,
             p.ESTRATEGIAIDSICC,
             p.CODIGOOFERTA,
             p.NUMEROGRUPO,
             p.NUMERONIVEL,
             p.MARCAID,
             m.DESCRIPCION,
             mc.IDMATRIZCOMERCIAL,
             mci.FOTO AS ImagenURL,
             '',
             Rtrim(p.CODIGOCATALAGO) AS CodigoCatalago,
             fb.NOMBRE,
             ga.DESCRIPCIONCORTA,
             sl.DESCRIPCIONLARGA,
             p.PRECIOCATALOGO,
             p.PRECIOVALORIZADO,
             p.FACTORREPETICION,
             Rtrim(p.CODIGOTIPOOFERTA) AS CodigoTipoOferta
      FROM   ods.productocomercial p WITH (nolock)
             INNER JOIN dbo.marca m WITH (nolock) ON m.MARCAID = p.MARCAID
             LEFT JOIN ods.sap_producto sp WITH (nolock) ON p.CODIGOPRODUCTO = sp.CODIGOSAP
             LEFT JOIN ods.sap_linea sl WITH (nolock) ON sp.CODIGOLINEA = sl.CODIGO
             LEFT JOIN ods.sap_grupoarticulo ga WITH (nolock) ON sp.CODIGOGRUPOARTICULOSAP = ga.CODIGO
             LEFT JOIN dbo.filtrobuscadorgrupoarticulo fbga WITH (nolock) ON ga.CODIGO = fbga.CODIGOGRUPOARTICULO
             LEFT JOIN dbo.filtrobuscador fb WITH (nolock) ON fbga.CODIGOFILTROBUSCADOR = fb.CODIGO
             LEFT JOIN dbo.productodescripcion pd WITH (nolock) ON p.ANOCAMPANIA = pd.CAMPANIAID AND p.CUV = pd.CUV
             LEFT JOIN dbo.matrizcomercial mc WITH (nolock) ON p.CODIGOPRODUCTO = mc.CODIGOSAP
             LEFT JOIN dbo.matrizcomercialimagen mci WITH (nolock) ON mci.IDMATRIZCOMERCIAL = mc.IDMATRIZCOMERCIAL AND mci.NEMOTECNICO IS NOT NULL
      WHERE  p.CAMPANIAID IN (SELECT CAMPANIAID  FROM   @cteCampanias)

      CREATE TABLE #productocomercial
        (
           CAMPANIAID         INT,
           CUV                VARCHAR(50),
           PRECIOUNITARIO     NUMERIC(12, 2),
           FACTORREPETICION   INT,
           INDICADORDIGITABLE BIT,
           ANOCAMPANIA        INT,
           INDICADORPREUNI    NUMERIC(12, 2),
           CODIGOFACTORCUADRE NUMERIC(12, 2),
           ESTRATEGIAIDSICC   INT,
           CODIGOOFERTA       INT,
           NUMEROGRUPO        INT,
           NUMERONIVEL        INT
        )

      INSERT INTO #productocomercial
      SELECT PC.CAMPANIAID,
             PC.CUV,
             PC.PRECIOUNITARIO,
             PC.FACTORREPETICION,
             PC.INDICADORDIGITABLE,
             PC.ANOCAMPANIA,
             PC.INDICADORPREUNI,
             PC.CODIGOFACTORCUADRE,
             PC.ESTRATEGIAIDSICC,
             PC.CODIGOOFERTA,
             PC.NUMEROGRUPO,
             PC.NUMERONIVEL
      FROM   ods.productocomercial PC WITH (nolock)
      WHERE  PC.CAMPANIAID IN (SELECT CAMPANIAID FROM   @cteCampanias)

      CREATE TABLE #productonivel
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVEL   INT,
           PRECIO  NUMERIC(12, 2)
        )

      INSERT INTO #productonivel
      SELECT PC.CUV,
             PC.ANOCAMPANIA,
             Nivel = PN.FACTORCUADRE,
             Precio = PN.PRECIOUNITARIO
      FROM   #productocomercial PC JOIN ods.productonivel PN ON PC.NUMERONIVEL = PN.NUMERONIVEL AND PN.FACTORCUADRE > 1
      GROUP  BY PC.CUV,
                PC.ANOCAMPANIA,
                PN.FACTORCUADRE,
                PN.PRECIOUNITARIO

      UPDATE pt
      SET    pt.GANANCIA = 0
      FROM   #productotemporal PT
      WHERE  pt.GANANCIA < 0

      UPDATE pn
      SET    PRECIO = pn.NIVEL * pn.PRECIO
      FROM   #productonivel PN

      CREATE TABLE #productoniveles
        (
           CUV     VARCHAR(5),
           CAMPANA INT,
           NIVELES VARCHAR(200)
        )

      INSERT INTO #productoniveles
      SELECT PN.CUV,
             PN.CAMPANA,
             Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) + 'X'
                                             +
                                             '-'
                                             + CONVERT(VARCHAR, PRECIO)
                                      FROM   #productonivel
                                      WHERE  CUV = PN.CUV
                                         AND CAMPANA = PN.CAMPANA
                                      FOR xml path(''), type).value('.[1]',
                               'varchar(200)'),
                               1, 1, ''))
      FROM   #productonivel PN
      GROUP  BY PN.CUV,
                PN.CAMPANA

      UPDATE pt
      SET    pt.NIVELES = PNS.NIVELES
      FROM   #productotemporal PT
             JOIN #productoniveles PNS
               ON PT.CUV = PNS.CUV
                  AND PT.CODIGOCAMPANIA = PNS.CAMPANA

      SELECT *
      FROM   #productotemporal
      DROP TABLE #productocomercial
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
      DROP TABLE #productotemporal
  END 

GO

