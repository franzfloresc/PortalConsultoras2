------------------------------------------------
-- Creacion de stores para configuracion pais
------------------------------------------------

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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

CREATE PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

CREATE PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
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