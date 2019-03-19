GO
USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14801)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14801, 'categorias.keyword', 'term');
END

IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14802)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14802, 'marcas.keyword', 'term');
END
IF NOT EXISTS(SELECT 1 FROM FiltroSeccion WHERE TablaLogicaDatosId = 14803)
BEGIN
INSERT INTO filtroSeccion (TablaLogicaDatosId, CampoES, TipoOperadorES) VALUES(14803, 'precio', 'range');
END

GO
