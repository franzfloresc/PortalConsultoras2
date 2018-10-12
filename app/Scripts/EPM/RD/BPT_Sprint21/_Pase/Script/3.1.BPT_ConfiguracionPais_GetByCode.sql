USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais_GetByCode]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPais_GetByCode]
GO
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetByCode] 
	@Codigo varchar(5)
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

