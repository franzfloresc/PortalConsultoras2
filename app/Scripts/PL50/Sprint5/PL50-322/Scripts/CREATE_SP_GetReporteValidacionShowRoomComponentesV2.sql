 USE BelcorpBolivia
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpChile
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpColombia
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpCostaRica
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpDominicana
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpEcuador
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpGuatemala
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpMexico
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpPanama
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpPeru
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpPuertoRico
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpSalvador
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
USE BelcorpVenezuela
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomComponentesV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomComponentesV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomComponentesV2
 @campania INT
AS  

BEGIN 
--Bolivia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpBolivia.Showroom.Evento e
	INNER JOIN BelcorpBolivia.dbo.Pais p ON estadoactivo = 1
	INNER JOIN ODS_BO.dbo.Campania c ON c.codigo = e.campaniaid
	INNER JOIN BelcorpBolivia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpBolivia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Chile
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpChile.Showroom.Evento e
	INNER JOIN BelcorpChile.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CL.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpChile.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpChile.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
--Colombia
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpColombia.Showroom.Evento e
	INNER JOIN BelcorpColombia.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpColombia.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpColombia.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Costa Rica 
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpCostaRica.Showroom.Evento e
	INNER JOIN BelcorpCostaRica.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_CR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpCostaRica.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpCostaRica.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Dominicana
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpDominicana.Showroom.Evento e
	INNER JOIN BelcorpDominicana.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_DO.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpDominicana.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpDominicana.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Ecuador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpEcuador.Showroom.Evento e
	INNER JOIN BelcorpEcuador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_EC.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpEcuador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpEcuador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Guatemala
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpGuatemala.Showroom.Evento e
	INNER JOIN BelcorpGuatemala.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_GT.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpGuatemala.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpGuatemala.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Mexico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpMexico.Showroom.Evento e
	INNER JOIN BelcorpMexico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_MX.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpMexico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpMexico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Panama
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPanama.Showroom.Evento e
	INNER JOIN BelcorpPanama.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PA.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPanama.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPanama.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Perú
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPeru.Showroom.Evento e
	INNER JOIN BelcorpPeru.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPeru.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPeru.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Puerto Rico
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpPuertoRico.Showroom.Evento e
	INNER JOIN BelcorpPuertoRico.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_PR.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpPuertoRico.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpPuertoRico.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Salvador
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpSalvador.Showroom.Evento e
	INNER JOIN BelcorpSalvador.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_SV.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpSalvador.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpSalvador.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

UNION 
-- Venezuela
SELECT
	p.codigoiso Pais,
	e.campaniaid Campania,
	es.CUV2 CUV,
	ISNULL(ep.nombreproducto, '') Nombre,
	ISNULL(ep.descripcion1, '') Descripcion1,
	(CASE WHEN ISNULL(ep.imagenProducto, '') = '' THEN '0' ELSE '1' END) FlagImagenCargada
FROM BelcorpVenezuela.Showroom.Evento e
	INNER JOIN BelcorpVenezuela.dbo.Pais p	ON estadoactivo = 1
	INNER JOIN ODS_VE.dbo.Campania c 	ON c.codigo = e.campaniaid
	INNER JOIN BelcorpVenezuela.dbo.Estrategia es	ON es.CampaniaID = c.Codigo
	INNER JOIN BelcorpVenezuela.dbo.EstrategiaProducto ep ON ep.Campania = es.CampaniaID 	AND ep.EstrategiaId = es.EstrategiaId
	INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON es.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE e.campaniaid = @campania	AND ep.Campania = @campania

 ORDER BY 1,3
END
GO
