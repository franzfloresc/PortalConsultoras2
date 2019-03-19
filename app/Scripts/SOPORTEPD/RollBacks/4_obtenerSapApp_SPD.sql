USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerSapApp]    Script Date: 18/02/2019 12:00:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerSapApp]
AS
BEGIN
	DECLARE @NumeroCampaniasBuscar INT
	DECLARE @CampaniaActual INT
	DECLARE @CampaniaSiguiente INT
	DECLARE @CampaniaSubSiguiente INT
	DECLARE @CampaniaInicioActual INT
	DECLARE @CampaniaInicioSiguiente INT
	DECLARE @CampaniaInicioSubSiguiente INT
	DECLARE @IsoPais VARCHAR(5)

	SET @NumeroCampaniasBuscar = 5
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);
	SET @CampaniaInicioActual = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaActual, @NumeroCampaniasBuscar);
	SET @CampaniaInicioSiguiente = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaSiguiente, @NumeroCampaniasBuscar);
	SET @CampaniaInicioSubSiguiente = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaSubSiguiente, @NumeroCampaniasBuscar);
	SELECT @IsoPais = CodigoApp FROM Pais where EstadoActivo =1

	SELECT 
		@IsoPais AS IsoPais,
		CASE Campania 
		  WHEN @CampaniaActual THEN @CampaniaInicioActual 
		  WHEN @CampaniaSiguiente THEN @CampaniaInicioSiguiente  
		  WHEN @CampaniaSubSiguiente THEN @CampaniaInicioSubSiguiente
		END AS CampaniaIncio,
		Campania,
		SAP AS CodigoSap
	FROM EstrategiaProducto
	WHERE Campania IN (@CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente)
	GROUP BY Campania, SAP
	ORDER BY Campania
END