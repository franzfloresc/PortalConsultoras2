GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Expofertas', 'sec-exp', '', '', '', 0)
  END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
  BEGIN
      DECLARE @id INT = (SELECT CONVERT(INT, Max(tablalogicadatosid)) + 1 FROM   tablalogicadatos WHERE  tablalogicaid = 148)

      INSERT INTO tablalogicadatos (tablalogicadatosid, tablalogicaid, codigo, descripcion, valor)
	  VALUES      (@id, 148, 'SEC', 'Filtro Secciones', 'Secciones')
      INSERT INTO filtroseccion (tablalogicadatosid, campoes, tipooperadores)
	  VALUES     (@id, 'seccion.keyword', 'term')

      INSERT INTO filtrobuscador (tablalogicadatosid, estado, codigo, nombre, descripcion, valorminimo, valormaximo, imagen, imagenancha)
      VALUES      (@id, 0, 401, 'Gana+ / Ofertas', 'sec-gana', '', '', '', 0),
                  (@id, 0, 402, 'Catálogo', 'sec-cat', '', '', '', 0),
				  (@id, 0, 403, 'Liquidaciones', 'sec-liq', '', '', '', 0)
  END

GO
