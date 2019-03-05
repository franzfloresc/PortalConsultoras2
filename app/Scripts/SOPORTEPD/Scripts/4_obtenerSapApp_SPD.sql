USE [BelcorpPeru]
GO
/****** Object:  EXEC [dbo].[ObtenerSapApp] 4,1   Script Date: 14/01/2019 1:42:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerSapApp]
(
@NumeroCampaniasBuscarAtras INT =NULL,
@NumeroCampaniasBuscarAdelante INT =NULL
)
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
	DECLARE @NuevaCampanaAdelante INT
    DECLARE @campInicio INT, @campFin INT

	IF (@NumeroCampaniasBuscarAtras IS NULL)
	BEGIN
	SELECT @NumeroCampaniasBuscarAtras=valor  FROM TABLALOGICADATOS WHERE TABLALOGICADATOSID =15601
	END
	IF (@NumeroCampaniasBuscarAdelante IS NULL)
	BEGIN
	SELECT @NumeroCampaniasBuscarAdelante=valor  FROM TABLALOGICADATOS WHERE TABLALOGICADATOSID =15602
	END

	

	SET @NumeroCampaniasBuscar = @NumeroCampaniasBuscarAtras
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);
	SET @CampaniaInicioActual = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaActual, @NumeroCampaniasBuscar);
	SET @CampaniaInicioSiguiente = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaSiguiente, @NumeroCampaniasBuscar);
	SET @CampaniaInicioSubSiguiente = dbo.fnObtenerCampaniaAnteriorNum(@CampaniaSubSiguiente, @NumeroCampaniasBuscar);

	IF (@NumeroCampaniasBuscarAdelante <=0)
	SELECT @NuevaCampanaAdelante=dbo.fnGetCampaniaActualPais();
	ELSE
	SELECT @NuevaCampanaAdelante=max(codigo) FROM  ---ADDED FROM SOPORTEPD-53
    (SELECT TOP (@NumeroCampaniasBuscarAdelante) codigo  
    FROM ods.campania WHERE codigo>@CampaniaActual ORDER BY codigo ASC) AS cct;
	


	SELECT @IsoPais = CodigoApp FROM Pais where EstadoActivo =1

	SELECT 
		@IsoPais AS IsoPais,
		CASE Campania 
		  WHEN @CampaniaActual THEN @CampaniaInicioActual 
		  WHEN @CampaniaSiguiente THEN @CampaniaInicioSiguiente  
		  WHEN @CampaniaSubSiguiente THEN @CampaniaInicioSubSiguiente
		END AS CampaniaIncio,
		Campania,
		@NuevaCampanaAdelante AS CampaniaFin,
		SAP AS CodigoSap
	FROM EstrategiaProducto
	WHERE Campania IN (@CampaniaActual, @CampaniaSiguiente, @CampaniaSubSiguiente)
	GROUP BY Campania, SAP
	ORDER BY Campania
END