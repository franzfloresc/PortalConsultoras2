/* REGISTRO PARA PERU */

USE BelcorpPeru
GO

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
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
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|676'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|676'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|676'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|676'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|676'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|folleto_brillante_2019_cr')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|682'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|682'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|682'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|682'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|682'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|folleto_brillante_2019_cl')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', '�sika', ''),
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

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|694'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|694'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|694'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|694'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|694'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|folleto_brillante_2019_bo')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtros')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, '00', 'Filtrar por', 'Marca'),
			(17401, 174, '02', '�sika', ''),
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

