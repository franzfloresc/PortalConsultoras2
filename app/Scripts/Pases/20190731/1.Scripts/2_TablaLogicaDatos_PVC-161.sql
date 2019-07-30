USE BelcorpColombia
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '24300');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '24300');

GO

USE BelcorpCostaRica
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '4900');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '4900');

GO

USE BelcorpChile
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '5000');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '5000');

GO

USE BelcorpBolivia
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '10000');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '10000');

GO

