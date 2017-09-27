USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
/*end*/

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll '','','','',''
*/
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
		,C.UrlMenu
		,C.OrdenBpt
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END
GO
