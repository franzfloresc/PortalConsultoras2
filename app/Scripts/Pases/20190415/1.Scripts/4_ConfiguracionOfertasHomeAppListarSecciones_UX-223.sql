USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones
@CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	;WITH CTE_CONFIG
	AS
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
			B.AppTitulo,   
			B.AppSubTitulo, 
			B.AppOrden,    
			B.AppBannerInformativo,    
			B.AppColorFondo,    
			B.AppColorTexto,    
			B.AppCantidadProductos,
			C.Codigo
		FROM dbo.ConfiguracionOfertasHome A (NOLOCK)
		INNER JOIN dbo.ConfiguracionOfertasHomeApp B (NOLOCK)
			ON A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
		INNER JOIN dbo.ConfiguracionPais C (NOLOCK)
			ON A.ConfiguracionPaisID = C.ConfiguracionPaisID
			AND AppActivo = 1
		WHERE CampaniaID <= @CampaniaId AND ISNULL(CampaniaID, 0) > 0
	)
	SELECT 
		AppTitulo, 
		AppSubTitulo,
		AppOrden, 
		AppBannerInformativo, 
		AppColorFondo,
		AppColorTexto,
		AppCantidadProductos,
		Codigo 
	FROM CTE_CONFIG 
	WHERE Correlativo = 1
END
GO

