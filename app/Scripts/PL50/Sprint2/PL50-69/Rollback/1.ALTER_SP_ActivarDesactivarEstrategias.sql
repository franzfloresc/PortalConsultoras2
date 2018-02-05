USE BelcorpPeru_PL50
GO

alter PROCEDURE ActivarDesactivarEstrategias

@UsuarioModificacion VARCHAR(100),

@EstrategiasActivas VARCHAR(500),

@EstrategiasDesactivas VARCHAR(500)

AS

BEGIN

	SET NOCOUNT ON

	

	DECLARE @resultado int = 0

	

	SELECT DISTINCT   E.EstrategiaID

	INTO #ESTRATEGIASNOACTIVAS

	FROM Estrategia E 	

	WHERE	

	E.EstrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,',')) AND

	((E.LimiteVenta IS NULL OR E.LimiteVenta = 0) OR 

	(E.ImagenURL IS NULL OR E.ImagenURL = ''))



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


