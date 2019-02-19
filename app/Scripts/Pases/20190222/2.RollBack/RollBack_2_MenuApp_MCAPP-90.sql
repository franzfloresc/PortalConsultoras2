USE BelcorpPeru
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpMexico
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpColombia
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpSalvador
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpPuertoRico
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpPanama
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpGuatemala
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpEcuador
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpDominicana
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpCostaRica
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpChile
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END

USE BelcorpBolivia
GO

IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
BEGIN
	-- Rollback
	UPDATE [MenuApp]
	SET Orden=Orden-1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
END