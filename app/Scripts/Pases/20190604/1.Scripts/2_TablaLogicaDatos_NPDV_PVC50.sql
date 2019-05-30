/* REGISTRO PARA PERU */

USE BelcorpPeru
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO


/* REGISTRO PARA MEXICO */


USE BelcorpMexico
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

/* REGISTRO PARA COLOMBIA */

USE BelcorpColombia
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

/* REGISTRO PARA EL SALVADOR */

USE BelcorpSalvador
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpPuertoRico
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpPanama
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpGuatemala
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpEcuador
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpDominicana
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpCostaRica
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpChile
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

USE BelcorpBolivia
GO

/* Enterate Más */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', 'Ésika', ''),
			(17402, 174, '01', 'L''bel', ''),
			(17403, 174, '03', 'Cyzone', '')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, '00', 'Ordenar por', ''),
			(17501, 175, '01', 'Categoria', ''),
			(17502, 175, '02', 'Nombre', '')
GO

