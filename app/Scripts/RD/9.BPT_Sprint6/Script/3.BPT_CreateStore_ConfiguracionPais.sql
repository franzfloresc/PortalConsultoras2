------------------------------------------------
-- Creacion de stores para configuracion pais
------------------------------------------------

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
/*
ConfiguracionPaisList 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
/*
ConfiguracionPaisGet 1
*/
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
		OrdenBpt
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250),
	@DesktopFondoBanner varchar(250),
	@MobileFondoBanner varchar(250),
	@DesktopLogoBanner varchar(250),
	@MobileLogoBanner varchar(250),
	@UrlMenu varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner, 
			DesktopFondoBanner = @DesktopFondoBanner,
			MobileFondoBanner = @MobileFondoBanner, 
			DesktopLogoBanner = @DesktopLogoBanner,
			MobileLogoBanner = @MobileLogoBanner,
			UrlMenu = @UrlMenu
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
GO
/*end*/