USE BelcorpPeru
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END

USE BelcorpMexico
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogicaDatos
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Mensaje importante escala descuento%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogicaDatos
	WHERE TablaLogicaID = 160;
END
GO


