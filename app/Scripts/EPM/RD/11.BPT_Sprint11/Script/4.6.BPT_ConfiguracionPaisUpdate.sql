USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
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
	@UrlMenu varchar(250),
	@OrdenBpt int,
	@MobileOrden int,
	@MobileOrdenBPT int

AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner,
								DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner, UrlMenu,
								OrdenBpt, MobileOrden, MobileOrdenBPT)
		VALUES (@Excluyente, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner,
								@DesktopFondoBanner, @MobileFondoBanner, @DesktopLogoBanner, @MobileLogoBanner, @UrlMenu,
								@OrdenBpt, @MobileOrden, @MobileOrdenBPT);
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
			UrlMenu = @UrlMenu,
			OrdenBpt = @OrdenBpt,
			MobileOrden = @MobileOrden,
			MobileOrdenBPT = @MobileOrdenBPT
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO

