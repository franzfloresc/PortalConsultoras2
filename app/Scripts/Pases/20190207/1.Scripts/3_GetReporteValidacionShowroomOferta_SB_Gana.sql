USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomOferta_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomOferta_SB  
 @campania INT    
AS  
SELECT
	e.CampaniaID AS 'Campania',
	pc.codigotipooferta AS 'CodigoTO',
	pc.codigoproducto AS 'SAP',
	e.CUV2  AS 'CUV',
	e.DescripcionCUV2  AS 'Descripcion',
	e.Precio AS 'PrecioValorizado',
	e.Precio2 AS 'PrecioOferta',
	e.LimiteVenta AS 'UnidadesPermitidas',
	ISNULL(e.EsSubCampania,0) AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	(IIF(LEN(e.ImagenURL)>1, 1, 0)) AS 'FlagImagenCargada',
	(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))  AS 'FlagImagenMini'
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania

GO

