USE BelcorpPeru
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpMexico
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpColombia
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpSalvador
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpPuertoRico
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpPanama
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpGuatemala
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpEcuador
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpDominicana
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpCostaRica
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpChile
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,1,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

USE BelcorpBolivia
GO

BEGIN TRY
	BEGIN TRAN CREA_MENU

	Delete from menuApp where versionMenu = 8

	insert into menuApp select Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu = 8, Descripcion2, Descripcion3
	from MenuApp where versionMenu = 7

	IF(EXISTS(SELECT CodigoMenuPadre FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8))
	BEGIN
		-- Rollback
		UPDATE [MenuApp]
		SET Orden=Orden-1
		WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

		DELETE FROM [MenuApp] WHERE Codigo='MEN_LAT_PEDIDOPEND' AND CodigoMenuPadre='MEN_LAT_NEGOCIO' AND VersionMenu=8
	END
	--Insert Menu Pedidos Pendiente
	UPDATE [MenuApp]
	SET Orden=Orden+1
	WHERE CODIGOMENUPADRE='MEN_LAT_NEGOCIO' AND Visible=1 AND VersionMenu=8 AND Orden>2

	INSERT INTO [MenuApp]
				([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu])
			VALUES
				('MEN_LAT_PEDIDOPEND','PEDIDOS PENDIENTES',3,'MEN_LAT_NEGOCIO',4,0,8)
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@ERROR>1)
	BEGIN
		ROLLBACK TRAN
	END
END CATCH

GO