USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.ACTUALIZARPRECIOSESTRATEGIA'))
Begin
	Drop PROC ACTUALIZARPRECIOSESTRATEGIA
End
GO

CREATE PROCEDURE dbo.ACTUALIZARPRECIOSESTRATEGIA
AS
  BEGIN
      SET quoted_identifier ON
      SET ansi_nulls ON

      DECLARE @CampaniaActual INT =0 --= 201810
      DECLARE @CampaniaSiguiente INT = 0
      DECLARE @CampaniaSubSiguiente INT = 0

      SET @CampaniaActual = dbo.FNGETCAMPANIAACTUALPAIS();
      SET @CampaniaSiguiente = dbo.FNGETCAMPANIASIGUIENTE(@CampaniaActual);
      SET @CampaniaSubSiguiente =
      dbo.FNGETCAMPANIASIGUIENTE(@CampaniaSiguiente);

      BEGIN
          CREATE TABLE #estrategiatemporal
            (
               ESTRATEGIATEMPORALID INT NULL,
               CAMPANIAID           INT NULL,
               CUV                  VARCHAR(5) NULL,
               PRECIOOFERTA         DECIMAL(18, 2) NULL, --Precio2
               PRECIOTACHADO        DECIMAL(18, 2) NULL, --Precio
               PRECIOPUBLICO        DECIMAL(18, 2) NULL, --PrecioPublico
               GANANCIA             DECIMAL(18, 2) NULL, --Ganancia
               NIVELES              VARCHAR(200) NULL
            )

          INSERT INTO #estrategiatemporal
          SELECT ESTRATEGIAID,
                 CAMPANIAID,
                 CUV2,
                 PRECIO2,
                 PRECIO,
                 PRECIOPUBLICO,
                 GANANCIA,
                 NIVELES
          FROM   estrategia ET
          WHERE  ET.CAMPANIAID IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productocomercial
            (
               CAMPANIAID         INT NULL,
               CUV                VARCHAR(50) NULL,
               PRECIOUNITARIO     NUMERIC(12, 2) NULL,
               FACTORREPETICION   INT NULL,
               INDICADORDIGITABLE BIT NULL,
               ANOCAMPANIA        INT NULL,
               INDICADORPREUNI    NUMERIC(12, 2) NULL,
               CODIGOFACTORCUADRE NUMERIC(12, 2) NULL,
               ESTRATEGIAIDSICC   INT NULL,
               CODIGOOFERTA       INT NULL,
               NUMEROGRUPO        INT NULL,
               NUMERONIVEL        INT NULL,
               PRECIOOFERTA       NUMERIC(12, 2),
               PRECIOTACHADO      NUMERIC(12, 2),
               GANANCIA           NUMERIC(12, 2)
            )

          INSERT INTO #productocomercial
          SELECT PC.ANOCAMPANIA,
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
                 PC.NUMERONIVEL,
                 PC.MONTOTOTALCATALOGO, --PrecioOferta|PrecioPublico
                 PC.MONTOTOTALPUBLICO, --PrecioTachado
                 PC.GANANCIATOTAL --Ganancia
          FROM   ods.productocomercial PC
          WHERE  PC.ANOCAMPANIA IN ( @CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente )

          CREATE TABLE #productonivel
            (
               CUV        VARCHAR(5) NULL,
               CAMPANIAID INT NULL,
               NIVEL      INT NULL,
               PRECIO     NUMERIC(12, 2) NULL
            )

          INSERT INTO #productonivel
          SELECT ET.CUV,
                 ET.CAMPANIAID,
                 Nivel = PN.FACTORCUADRE,
                 Precio = PN.PRECIOUNITARIO
          FROM   #estrategiatemporal ET
                 JOIN #productocomercial PC
                   ON ET.CUV = PC.CUV
                      AND ET.CAMPANIAID = PC.CAMPANIAID
                 JOIN ods.productonivel PN
                   ON PC.NUMERONIVEL = PN.NUMERONIVEL
                      AND PN.CAMPANA = PC.CAMPANIAID
                      AND PN.FACTORCUADRE > 1
          GROUP  BY ET.CUV,
                    ET.CAMPANIAID,
                    PN.FACTORCUADRE,
                    PN.PRECIOUNITARIO
      END

      BEGIN
          UPDATE e
          SET    e.PRECIOPUBLICO = PC.PRECIOOFERTA,
                 e.PRECIOTACHADO = PC.PRECIOTACHADO,
                 e.PRECIOOFERTA = PC.PRECIOOFERTA,
                 e.GANANCIA = PC.GANANCIA
          FROM   #estrategiatemporal E
                 INNER JOIN #productocomercial PC
                         ON E.CUV = PC.CUV
                            AND E.CAMPANIAID = PC.CAMPANIAID

          UPDATE et
          SET    et.GANANCIA = 0
          FROM   #estrategiatemporal ET
          WHERE  et.GANANCIA < 0
      END

      BEGIN
          UPDATE pn
          SET    PRECIO = pn.NIVEL * pn.PRECIO
          FROM   #productonivel PN

          CREATE TABLE #productoniveles
            (
               CUV        VARCHAR(5),
               CAMPANIAID INT NULL,
               NIVELES    VARCHAR(200)
            )

          INSERT INTO #productoniveles
                      (CUV,
                       CAMPANIAID,
                       NIVELES)
          SELECT PN.CUV,
                 PN.CAMPANIAID,
                 Niveles = (SELECT Stuff((SELECT '|' + CONVERT(VARCHAR, NIVEL) +
                                                 'X' +
                                                 '-'
                                                 + CONVERT(VARCHAR, PRECIO)
                                          FROM   #productonivel
                                          WHERE  CUV = PN.CUV
                                             AND CAMPANIAID = PN.CAMPANIAID
                                          FOR xml path(''), type).value('.[1]',
                                   'varchar(200)'),
                                   1, 1, ''))
          FROM   #productonivel PN
          GROUP  BY PN.CAMPANIAID,
                    PN.CUV

          UPDATE et
          SET    et.NIVELES = PNS.NIVELES
          FROM   #estrategiatemporal ET
                 JOIN #productoniveles PNS
                   ON ET.CUV = PNS.CUV
                      AND ET.CAMPANIAID = PNS.CAMPANIAID
      END

      DECLARE @UserEtl VARCHAR(20)
      DECLARE @Now DATETIME

      SET @UserEtl = 'USER_ETL'

      SELECT @Now = [dbo].[FNOBTENERFECHAHORAPAIS] ()

      UPDATE T
      SET    T.PRECIO2 = S.PRECIOOFERTA,
             T.PRECIO = S.PRECIOTACHADO,
             T.PRECIOPUBLICO = S.PRECIOPUBLICO,
             T.GANANCIA = S.GANANCIA,
             T.NIVELES = S.NIVELES,
             T.USUARIOMODIFICACION = @UserEtl,
             T.FECHAMODIFICACION = @Now
      FROM   estrategia T
             JOIN #estrategiatemporal S
               ON T.ESTRATEGIAID = S.ESTRATEGIATEMPORALID

      DROP TABLE #productocomercial
      DROP TABLE #estrategiatemporal
      DROP TABLE #productonivel
      DROP TABLE #productoniveles
  END 

GO

