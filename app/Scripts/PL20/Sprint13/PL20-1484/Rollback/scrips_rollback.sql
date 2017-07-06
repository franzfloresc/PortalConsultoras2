
USE BelcorpBolivia
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpChile
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpColombia
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpCostaRica
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpDominicana
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpEcuador
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpGuatemala
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpMexico
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpPanama
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpPeru
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpPuertoRico
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpSalvador
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO
/*end*/

USE BelcorpVenezuela
go

IF EXISTS (SELECT 1 FROM PopupPais WHERE CodigoPopup = 10)
BEGIN
	DECLARE @ORDEN_CUPON INT;

	SET @ORDEN_CUPON	= (SELECT Orden FROM PopupPais WHERE CodigoPopup = 10);

	DELETE FROM PopupPais WHERE CodigoPopup = 10

	UPDATE	PopupPais
	SET		Orden = (Orden - 1)
	WHERE	Orden > @ORDEN_CUPON
END
GO

