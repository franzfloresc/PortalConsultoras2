USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

 SELECT AppTitulo, AppOrden, AppBannerInformativo, AppColorFondo,AppColorTexto,AppCantidadProductos,Codigo FROM (
	SELECT
	ROW_NUMBER() OVER(PARTITION BY A.ConfiguracionPaisID ORDER BY CampaniaId DESC) AS Correlativo,
	B.AppTitulo ,    
	B.AppOrden,    
	B.AppBannerInformativo,    
	B.AppColorFondo,    
	B.AppColorTexto,    
	B.AppCantidadProductos  
	,C.Codigo
	from ConfiguracionOfertasHome A
	inner join ConfiguracionOfertasHomeApp B
	on A.ConfiguracionOfertasHomeID = b.ConfiguracionOfertasHomeID
	inner join ConfiguracionPais C 
	on A.ConfiguracionPaisID = C.ConfiguracionPaisID
	and AppActivo = 1
	where CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
 ) T WHERE Correlativo=1

END
GO

