/* REGISTRO PARA PERU */

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


