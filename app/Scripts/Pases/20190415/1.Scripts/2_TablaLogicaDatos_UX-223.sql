USE BelcorpPeru
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpMexico
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpColombia
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpSalvador
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpPuertoRico
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpPanama
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpGuatemala
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpEcuador
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpDominicana
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpCostaRica
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpChile
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

USE BelcorpBolivia
GO

DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_mdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_hdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxhdpi'
DELETE FROM dbo.TablaLogicaDatos WHERE Codigo = 'ATP_xxxhdpi'

DECLARE @TablaLogicaDatosID SMALLINT

SELECT @TablaLogicaDatosID = MAX(TablaLogicaDatosID) FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 1, 162, 'ATP_mdpi', '210x140', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 2, 162, 'ATP_hdpi', '315x210', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 3, 162, 'ATP_xhdpi', '420x280', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 4, 162, 'ATP_xxhdpi', '630x420', NULL)
INSERT INTO dbo.TablaLogicaDatos VALUES (@TablaLogicaDatosID + 5, 162, 'ATP_xxxhdpi', '840x560', NULL)
GO

