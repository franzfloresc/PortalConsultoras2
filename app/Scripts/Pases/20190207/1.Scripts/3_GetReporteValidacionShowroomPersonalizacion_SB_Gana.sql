USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomPersonalizacion_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomPersonalizacion_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowroomPersonalizacion_SB  201902
BEGIN

SELECT pp.codigoiso Pais,
       p.tipoaplicacion Medio, p.atributo, p.textoayuda Personalizacion,
       (CASE WHEN ISNULL(pn.personalizacionid, 0) = 0 THEN 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'0' 
			 ELSE 
					'' 
			 END) 
		ELSE 
			(CASE WHEN p.tipoatributo = 'IMAGEN' THEN 
					'1' 
			 ELSE 
					pn.valor 
			END) 
		END) AS FlagContenido
FROM ShowRoom.Personalizacion p
INNER JOIN dbo.Pais pp ON pp.estadoactivo = 1
LEFT OUTER JOIN (SELECT pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     FROM ShowRoom.Evento e  
					 INNER JOIN ShowRoom.PersonalizacionNivel pn ON pn.eventoid = e.eventoid
						WHERE e.campaniaid = @campania) pn ON pn.personalizacionid = p.personalizacionid
	WHERE p.estado = 1  
	AND p.atributo != 'TituloPrincipal' 
	AND p.atributo != 'ImagenPrincipal' 
	AND p.atributo != 'ColorFondo'
END

GO


