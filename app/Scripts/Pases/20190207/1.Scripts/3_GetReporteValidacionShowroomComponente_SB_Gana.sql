USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomComponente_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomComponente_SB
 @campania INT
AS  

BEGIN 
	SELECT
		p.codigoiso AS 'Pais',
		e.campaniaid AS 'Campania',
		es.CUV2 AS 'CUV',
		ISNULL(ep.nombreproducto, '') AS 'Nombre',
		ISNULL(ep.descripcion1, '') AS 'Descripcion1',
		(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN 
			'0' 
		ELSE 
			'1' 
		END) AS 'FlagImagenCargada'
		FROM Showroom.Evento e
		INNER JOIN dbo.Pais p ON estadoactivo = 1
		INNER JOIN ods.Campania c ON c.codigo = e.campaniaid
		INNER JOIN dbo.Estrategia es ON es.CampaniaID = c.Codigo
		INNER JOIN dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
			WHERE e.campaniaid = @campania	
			AND ep.Campania = @campania
END
GO

