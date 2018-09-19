USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDO')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDO', 'PEDIDO', 4, '', 1, 0, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDO')
END
UPDATE dbo.MenuApp SET Visible = 0 WHERE VersionMenu = 4 AND Codigo IN ('MEN_LAT_PEDIDOSNAT','MEN_LAT_PEDIDO')
IF NOT EXISTS(SELECT 1 FROM dbo.MenuApp (NOLOCK) WHERE VersionMenu = 4 AND Codigo = 'MEN_TOP_PEDIDOSNAT')
BEGIN
	INSERT INTO dbo.MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu) VALUES ('MEN_TOP_PEDIDOSNAT', 'PEDIDO', 4, '', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE dbo.MenuApp SET Visible = 1 WHERE VersionMenu = 4 AND Codigo IN ('MEN_TOP_PEDIDOSNAT')
END
GO

