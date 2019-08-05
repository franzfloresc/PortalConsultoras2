USE BelcorpColombia
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '30375');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '30375');

GO

USE BelcorpCostaRica
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '6125');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '6125');

GO

USE BelcorpChile
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '6250');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '6250');

GO

USE BelcorpBolivia
GO

DELETE FROM TablaLogicaDatos where TablaLogicaDatosID in ( 17609, 17610);

INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17609, 176, 'sb_granBrillante', 'Gran Brillante', '12500');
INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
	VALUES (17610, 176, 'app_granBrillante', 'Gran Brillante', '12500');

GO

