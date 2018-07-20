USE BelcorpPeru;
GO
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 133 AND TablaLogicaDatosID in (13302, 13303, 13304, 13305);

UPDATE TablaLogicaDatos SET Valor='' WHERE TablaLogicaID = 133 AND Codigo = 'USUARIO';
UPDATE TablaLogicaDatos SET Valor='' WHERE TablaLogicaID = 133 AND Codigo = 'CLAVE';
GO

USE BelcorpBolivia;
GO
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 133 AND TablaLogicaDatosID = 13305;
GO