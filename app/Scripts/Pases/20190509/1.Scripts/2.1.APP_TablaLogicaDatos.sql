USE BelcorpPeru
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpMexico
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpColombia
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpSalvador
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpPuertoRico
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpPanama
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpGuatemala
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpEcuador
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpDominicana
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpCostaRica
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpChile
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

USE BelcorpBolivia
GO

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_xhdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_xhdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_xhdpi', '960x540', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_hdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_hdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_hdpi', '720x405', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_mdpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_mdpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_mdpi', '480x270', NULL);

IF(EXISTS(SELECT Codigo FROM dbo.TablaLogicaDatos WHERE  Codigo='HIST_ldpi'))
BEGIN
	DELETE FROM dbo.TablaLogicaDatos WHERE CODIGO='HIST_ldpi'
END
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor)
VALUES((SELECT ISNULL(MAX(TablaLogicaDatosID) + 1, 0) FROM dbo.TablaLogicaDatos), 162, 'HIST_ldpi', '360x202', NULL);

GO

