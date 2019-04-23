GO
USE BelcorpPeru
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 080 -11-3030 Provincias ó al 2113614 Lima')
	END
END

GO
USE BelcorpMexico
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 01-800-2352677')
	END
END

GO
USE BelcorpColombia
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 01-8000-9-37452 ó al 5948060 (Bogotá)')
	END
END

GO
USE BelcorpSalvador
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 800-37452-000 ó al 25101198 o 25101199 locales')
	END
END

GO
USE BelcorpPuertoRico
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 1-866-366-3235 (Isla) ó al 622-3235 (Área Metropolitana)')
	END
END

GO
USE BelcorpPanama
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 800-5235 Línea Gratuita ó al 377-9399 (Línea local)')
	END
END

GO
USE BelcorpGuatemala
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 1-801-81-37452 ó al 22856185 o 23843795 Locales')
	END
END

GO
USE BelcorpEcuador
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 1800-766672')
	END
END

GO
USE BelcorpDominicana
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 1-809-200-5235 ó al 809-620-5235 (Santo Domingo)')
	END
END

GO
USE BelcorpCostaRica
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 800-000-5235 ó al 22019601 o 22019602')
	END
END

GO
USE BelcorpChile
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center:  800-210-207 ó al 02-28762100 (desde un celular)')
	END
END

GO
USE BelcorpBolivia
GO
BEGIN
	DECLARE @varTablaLogicaDatosID INT=23001
	DECLARE @varTablaLogicaID INT=LEFT(CAST(@varTablaLogicaDatosID AS VARCHAR(5)),3)

	/*Tabla Lógica Datos */
	IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaDatosID=@varTablaLogicaDatosID)
	BEGIN
		INSERT INTO TablaLogicaDatos
		(TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor)
		VALUES
		(@varTablaLogicaDatosID,
		 @varTablaLogicaID,
		 '01',
		 'Mensaje en Pop-up Bloqueo para consultoras bloqueadas.',
		 'Si deseas mayor información contáctate con el call center: 3-3150600 (Fijo de Santa Cruz) ó al 800-10-5678 (desde un celular)')
	END
END

GO
