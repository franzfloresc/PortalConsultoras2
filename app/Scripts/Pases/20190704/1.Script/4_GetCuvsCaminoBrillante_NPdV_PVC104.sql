USE BelcorpPeru
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpMexico
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpColombia
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpSalvador
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpPuertoRico
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpPanama
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpGuatemala
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpEcuador
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpDominicana
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpCostaRica
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpChile
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

USE BelcorpBolivia
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
		--Kits Digitable (Cabecera)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , (CASE PROD.NumeroPagina 
					WHEN 204 THEN 'Kit Coral'
					WHEN 205 THEN 'Kit Ámbar'
					WHEN 206 THEN 'Kit Perla'
					WHEN 207 THEN 'Kit Topacio'
				ELSE PROD.Descripcion END) AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 1

		UNION ALL

		--Kits No Digitable (Detalle)
		SELECT  
			 PROD.CUV AS CUV
			 , PROD.NumeroPagina - 202 AS Nivel
			 , PROD.Descripcion AS Descripcion
			 , PROD.IndicadorDigitable AS IndicadorDigitable
			 , 1 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania= @CampaniaID 
			  AND PROD.NumeroPagina IN (204, 205, 206, 207)
			  AND PROD.IndicadorDigitable = 0

		UNION ALL

		--Demostradores Digitable
		SELECT  
			PROD.CUV AS CUV
			, PROD.NumeroPagina - 199 AS Nivel
			, PROD.Descripcion AS Descripcion
			, PROD.IndicadorDigitable AS IndicadorDigitable
			, 2 AS Tipo
		FROM ods.productocomercial AS PROD WITH (NOLOCK) 
		WHERE PROD.AnoCampania = @CampaniaID
			and PROD.CodigoCatalago = 35 
			and PROD.NumeroPagina IN (200,201,202,203)

	END
END 
GO

