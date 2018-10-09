USE [BelcorpPeru_BPT]
GO
/****** Object:  StoredProcedure [dbo].[EstrategiaTemporalActualizarSetImagen]    Script Date: 9/10/2018 15:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******CREADO POR: JORGE LEIVA DIAZ ******/
/******RESULTADO : ACTUALIZA LA IMAGEN DE ESTRATEGIA IMAGEN A ESTRATEGIA TEMPORAL ******/
/******PARAMETROS: NUMERO LOTE Y PAGINA ******/

ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarSetImagen]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET @NroLote = ISNULL(@NroLote, 0)
	SET @Pagina = ISNULL(@Pagina, 0)
	IF @NroLote > 0 and @Pagina >= 0
	BEGIN	
		SELECT ei.CampaniaID, ei.CUV, ei.NombreImagen, max(ei.Fecha) as Fecha
		INTO #EstrategiaImagen_Temp
		FROM EstrategiaImagen ei
			INNER JOIN EstrategiaTemporal et
			ON ei.CUV = et.CUV 
				AND et.CampaniaId = ei.CampaniaID
		WHERE et.NumeroLote = @NroLote 
			AND et.Pagina = @Pagina
		group by ei.CampaniaID, ei.CUV, ei.NombreImagen
		--ORDER BY ei.fecha DESC

		UPDATE EstrategiaTemporal
		SET FotoProducto01 = eit.NombreImagen
		FROM EstrategiaTemporal
			INNER JOIN #EstrategiaImagen_Temp eit
			ON eit.CUV = EstrategiaTemporal.CUV 
				AND EstrategiaTemporal.CampaniaId = eit.CampaniaID
		WHERE EstrategiaTemporal.NumeroLote = @NroLote 
			AND EstrategiaTemporal.Pagina = @Pagina

	DROP TABLE #EstrategiaImagen_Temp
	END
END

