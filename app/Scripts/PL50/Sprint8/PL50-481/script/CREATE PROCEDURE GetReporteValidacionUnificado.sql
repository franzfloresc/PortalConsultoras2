USE BelcorpPeru
GO

IF (OBJECT_ID('dbo.GetReporteValidacionUnificado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetReporteValidacionUnificado AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetReporteValidacionUnificado] @CampaniaID INT
	,@TipoEstrategia INT
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
		DECLARE @teIDBolivia INT;
		DECLARE @teIDChile INT;
		DECLARE @teIDColombia INT;
		DECLARE @teIDCostaRica INT;
		DECLARE @teIDDominicana INT;
		DECLARE @teIDEcuador INT;
		DECLARE @teIDGuatemala INT;
		DECLARE @teIDMexico INT;
		DECLARE @teIDPanama INT;
		DECLARE @teIDPeru INT;
		DECLARE @teIDPuertoRico INT;
		DECLARE @teIDSalvador INT;
		DECLARE @teIDVenezuela INT;
		DECLARE @TipoPersonalizacion VARCHAR(10);
		DECLARE @strDescEstrategicaSearch NVARCHAR(20);

		SET @strDescEstrategicaSearch = CASE @TipoEstrategia
				WHEN '4'
					THEN '%Oferta para ti%'
				WHEN '7'
					THEN '%Oferta del D%'
				WHEN '10'
					THEN '%Mis Ofertas Simples%'
				END
		SET @TipoPersonalizacion = CASE @TipoEstrategia
				WHEN '4'
					THEN 'OPT'
				WHEN '7'
					THEN 'ODD'
				WHEN '10'
					THEN 'OPM'
				END;

		SELECT @teIDBolivia = TipoEstrategiaID
		FROM BelcorpBolivia.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDChile = TipoEstrategiaID
		FROM BelcorpChile.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDColombia = TipoEstrategiaID
		FROM BelcorpColombia.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDCostaRica = TipoEstrategiaID
		FROM BelcorpCostaRica.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDDominicana = TipoEstrategiaID
		FROM BelcorpDominicana.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDEcuador = TipoEstrategiaID
		FROM BelcorpEcuador.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDGuatemala = TipoEstrategiaID
		FROM BelcorpGuatemala.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDMexico = TipoEstrategiaID
		FROM BelcorpMexico.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDPanama = TipoEstrategiaID
		FROM BelcorpPanama.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDPeru = TipoEstrategiaID
		FROM BelcorpPeru.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDPuertoRico = TipoEstrategiaID
		FROM BelcorpPuertoRico.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDSalvador = TipoEstrategiaID
		FROM BelcorpSalvador.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @teIDVenezuela = TipoEstrategiaID
		FROM BelcorpVenezuela.dbo.TipoEstrategia
		WHERE DescripcionEstrategia LIKE @strDescEstrategicaSearch;

		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'BO' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpBolivia.dbo.Estrategia e
		INNER JOIN BelcorpBolivia.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpBolivia.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDBolivia
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'CL' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpChile.dbo.Estrategia e
		INNER JOIN BelcorpChile.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpChile.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDChile
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'CO' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpColombia.dbo.Estrategia e
		INNER JOIN BelcorpColombia.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpColombia.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDColombia
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'CR' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpCostaRica.dbo.Estrategia e
		INNER JOIN BelcorpCostaRica.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpCostaRica.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDCostaRica
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'DO' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpDominicana.dbo.Estrategia e
		INNER JOIN BelcorpDominicana.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpDominicana.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDDominicana
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'EC' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpEcuador.dbo.Estrategia e
		INNER JOIN BelcorpEcuador.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpEcuador.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDEcuador
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'GT' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpGuatemala.dbo.Estrategia e
		INNER JOIN BelcorpGuatemala.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpGuatemala.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDGuatemala
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'MX' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpMexico.dbo.Estrategia e
		INNER JOIN BelcorpMexico.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpMexico.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDMexico
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'PA' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpPanama.dbo.Estrategia e
		INNER JOIN BelcorpPanama.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpPanama.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDPanama
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'PE' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpPeru.dbo.Estrategia e
		INNER JOIN BelcorpPeru.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpPeru.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDPeru
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'PR' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpPuertoRico.dbo.Estrategia e
		INNER JOIN BelcorpPuertoRico.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpPuertoRico.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDPuertoRico
		
		UNION
		
		SELECT @TipoPersonalizacion AS TipoEstrategia
			,e.CampaniaID
			,'SV' AS Pais
			,e.CUV2
			,e.DescripcionCUV2
			,CASE 
				WHEN (
						@TipoEstrategia = '4'
						AND LEN(e.DescripcionCUV2) > 40
						)
					THEN SUBSTRING(e.DescripcionCUV2, 1, 40)
				ELSE e.DescripcionCUV2
				END AS DescripcionCorta
			,e.ImagenUrl
			,e.Precio AS PrecioNormal
			,e.Precio2 AS PrecioOfertaDigital
			,e.LimiteVenta
			,e.Activo
			,pc.CUV AS CUVPrecioTachado
			,pc.PrecioCatalogo AS PrecioTachado
		FROM BelcorpSalvador.dbo.Estrategia e
		INNER JOIN BelcorpSalvador.ods.Campania c ON c.Codigo = e.CampaniaID
		INNER JOIN BelcorpSalvador.ods.ProductoComercial pc ON c.CampaniaID = pc.CampaniaID
			AND pc.CUV = e.CUV2
		WHERE e.CampaniaID = @CampaniaID
			AND e.TipoEstrategiaID = @teIDSalvador
		

	END TRY

	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END