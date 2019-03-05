USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeAppListarSecciones]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ConfiguracionOfertasHomeAppListarSecciones]
GO

CREATE PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
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

