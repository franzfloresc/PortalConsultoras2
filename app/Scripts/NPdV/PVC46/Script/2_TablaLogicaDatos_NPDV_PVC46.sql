USE BelcorpPeru
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpMexico
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpColombia
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpSalvador
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpPuertoRico
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpPanama
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpGuatemala
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpEcuador
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

USE BelcorpDominicana
GO

/* Enterate M�s */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 173
DELETE FROM TablaLogica WHERE TablaLogicaID = 173
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (173, 'Camino Brillante - Enterate +');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
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
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
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
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
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
	VALUES (17301, 173, '1', 'Enterate M�s Nivel 1 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17302, 173, '2', 'Enterate M�s Nivel 2 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17303, 173, '3', 'Enterate M�s Nivel 3 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17304, 173, '4', 'Enterate M�s Nivel 4 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17305, 173, '5', 'Enterate M�s Nivel 5 (1: MiAcademia, 2: Issue)', '1|222'),
		   (17306, 173, '6', 'Enterate M�s Nivel 6 (1: MiAcademia, 2: Issue)', '2|esika.peru.c07.2019')
GO

/* Filtro Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 174
DELETE FROM TablaLogica WHERE TablaLogicaID = 174
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (174, 'Camino Brillante - Filtro Dem')
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17400, 174, 'FILTRO', 'FILTRAR POR', '00'),
			(17401, 174, 'FILTRO', 'L''BEL', '01'),
			(17402, 174, 'FILTRO', '�SIKA', '02'),
			(17403, 174, 'FILTRO', 'CYZONE', '03')
GO

/* Orden Demostradores */
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 175
DELETE FROM TablaLogica WHERE TablaLogicaID = 175
GO
INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (175, 'Camino Brillante - Orden Dem');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES  (17500, 175, 'ORDEN', 'ORDENAR POR', '00'),
			(17501, 175, 'ORDEN', 'CATEGORIA', '01'),
			(17502, 175, 'ORDEN', 'NOMBRE', '02')
GO

