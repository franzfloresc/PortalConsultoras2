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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
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
		 'Si deseas mayor información contáctate con el call center.')
	END
END

GO
