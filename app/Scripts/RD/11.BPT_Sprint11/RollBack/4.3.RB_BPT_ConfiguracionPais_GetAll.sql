
USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
	(
	@DesdeCampania int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
	)
	AS
	/*
	dbo.ConfiguracionPais_GetAll 0,'','','','',''
	*/
	BEGIN
	SET NOCOUNT ON;
	
	SET @DesdeCampania = ISNULL(@DesdeCampania, 0)
	
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
	WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0
	
	END

GO

