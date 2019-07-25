USE BelcorpPeru
GO

ALTER PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
BEGIN
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

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
--Kits Digitable (Cabecera)

IF 
(SELECT ESTADO FROM CONFIGURACIONPAIS WHERE CODIGO='CAMINOBRILLANTE') = 1
	BEGIN
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	  AND PROD.CodigoCatalago = 35 
	  AND PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'kit'))
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
	and PROD.NumeroPagina IN (select Valor from [dbo].[fn_GetCodigosNivelBrillante](178,'dem'))

END
END
GO
