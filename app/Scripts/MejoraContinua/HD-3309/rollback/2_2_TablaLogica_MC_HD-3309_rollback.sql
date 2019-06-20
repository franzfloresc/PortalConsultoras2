USE BelcorpPeru
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT 1
		FROM TablaLogica
		WHERE TablaLogicaID = 160
			AND descripcion LIKE '%Msj Importante Escala DSCTO%'
		)
BEGIN
	DELETE
	FROM dbo.TablaLogica
	WHERE TablaLogicaID = 160;
END
GO


