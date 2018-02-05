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

		WHERE estrategiaID IN (SELECT splitdata FROM dbo.fnSplitString(@EstrategiasActivas,','))

	END



	select @resultado



	SET NOCOUNT OFF

END


