GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EstrategiaTemporalActualizarSetImagen]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EstrategiaTemporalActualizarSetImagen]
GO

CREATE PROCEDURE EstrategiaTemporalActualizarSetImagen
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET @NroLote = ISNULL(@NroLote, 0)
	IF @NroLote > 0
	BEGIN
		
		declare @Campaniaid int
		select @Campaniaid = CampaniaId from EstrategiaTemporal where NumeroLote = @NroLote and Pagina = @Pagina


		update EstrategiaTemporal
		set FotoProducto01 = 
		from EstrategiaTemporal t
			inner t.cuv = 

	END
END

