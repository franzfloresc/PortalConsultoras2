USE [BelcorpPeru_BPT]
GO

--USE [BelcorpChile_BPT]
--GO

--USE [BelcorpCostaRica_BPT]
--GO

DELETE FROM TablaLogicaDatos
WHERE TablaLogicaDatosID = 13702 AND Descripcion = 'Estrategia Imagenes'

INSERT INTO TablaLogicaDatos
VALUES (13702, 137, 1, 'Estrategia Imagenes', null)
