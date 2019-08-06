USE [BelcorpBolivia];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpChile];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpColombia];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpCostaRica];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpDominicana];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpEcuador];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpGuatemala];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpMexico];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpPanama];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpPeru];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpPuertoRico];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
USE [BelcorpSalvador];
GO
ALTER PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
	@Codigo varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado,
		TienePerfil,
		DesdeCampania,
		MobileTituloMenu,
		DesktopTituloMenu,
		Logo,
		Orden,
		DesktopTituloBanner,
		MobileTituloBanner,
		DesktopSubTituloBanner,
		MobileSubTituloBanner,
		DesktopFondoBanner,
		MobileFondoBanner,
		DesktopLogoBanner,
		MobileLogoBanner,
		UrlMenu,
		OrdenBpt,
		MobileOrden,
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO
