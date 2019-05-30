USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetCuvsCaminoBrillante'))
Begin
	Drop PROC GetCuvsCaminoBrillante
End
GO
CREATE PROC [dbo].[GetCuvsCaminoBrillante] (
	@CampaniaID int
)
As
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
GO

