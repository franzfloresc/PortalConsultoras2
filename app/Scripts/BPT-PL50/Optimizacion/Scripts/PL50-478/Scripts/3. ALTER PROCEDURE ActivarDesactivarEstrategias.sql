 use belcorpBolivia
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpChile
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpColombia
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpCostaRica
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpDominicana
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpEcuador
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpGuatemala
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpMexico
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpPanama
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpPeru
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpPuertoRico
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
use belcorpSalvador
 go

IF (OBJECT_ID('dbo.ActivarDesactivarEstrategias', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ActivarDesactivarEstrategias AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ActivarDesactivarEstrategias @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
GO
