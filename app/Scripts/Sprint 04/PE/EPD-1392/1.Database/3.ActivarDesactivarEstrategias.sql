USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivarDesactivarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActivarDesactivarEstrategias]
GO

CREATE PROCEDURE ActivarDesactivarEstrategias
@UsuarioModificacion VARCHAR(100),
@EstrategiasActivas VARCHAR(500),
@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @resultado int = 0
		
	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E 
	INNER JOIN ODS.ProductoComercial PC ON E.CUV2 = PC.CUV
	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	WHERE
	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND
	(E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR
	(MC.FotoProducto01 IS NULL OR MC.FotoProducto01 = '')  AND
	(MC.FotoProducto02 IS NULL OR MC.FotoProducto02 = '')  AND
	(MC.FotoProducto03 IS NULL OR MC.FotoProducto03 = '')  AND
	(MC.FotoProducto04 IS NULL OR MC.FotoProducto04 = '')  AND
	(MC.FotoProducto05 IS NULL OR MC.FotoProducto05 = '')  AND
	(MC.FotoProducto06 IS NULL OR MC.FotoProducto06 = '')  AND
	(MC.FotoProducto07 IS NULL OR MC.FotoProducto07 = '')  AND
	(MC.FotoProducto08 IS NULL OR MC.FotoProducto08 = '')  AND
	(MC.FotoProducto09 IS NULL OR MC.FotoProducto09 = '')  AND
	(MC.FotoProducto10 IS NULL OR MC.FotoProducto10 = '')  

	SELECT splitdata 
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas,',') EA 
	WHERE EA.splitdata NOT IN (SELECT EstrategiaID FROM #ESTRATEGIASNOACTIVAS)
	
	SELECT @resultado = COUNT (*) FROM #ESTRATEGIASNOACTIVAS
	
	-- Desactivar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasDesactivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasDesactivas,','))
	END
	-- Activar
	IF ((SELECT count(splitdata) FROM dbo.fnSplitString(@EstrategiasActivas,',')) > 0)
	BEGIN
		UPDATE Estrategia 
		SET activo = 1, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  
		WHERE estrategiaID IN (SELECT splitdata FROM #ESTRATEGIASACTIVAR)
	END

	select @resultado

	SET NOCOUNT OFF
END

GO

