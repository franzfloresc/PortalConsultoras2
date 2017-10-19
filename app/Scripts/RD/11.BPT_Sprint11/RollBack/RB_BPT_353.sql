--ROLLBACK

ALTER TABLE dbo.ConfiguracionPais DROP CONSTRAINT MobileOrden_def  
GO 
ALTER TABLE dbo.ConfiguracionPais DROP CONSTRAINT MobileOrdenBPT_def 
GO 

ALTER TABLE dbo.ConfiguracionPais  DROP COLUMN MobileOrden; 
GO 
ALTER TABLE dbo.ConfiguracionPais  DROP COLUMN MobileOrdenBPT; 
GO 

-----------------------------------------------------------------------------

--ROLBACK

/****** Object:  StoredProcedure [dbo].[ConfiguracionPaisList]    Script Date: 16/10/2017 11:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ConfiguracionPaisList]
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

------------------------------------------------------------------------------------

--ROLLBACK

/****** Object:  StoredProcedure [dbo].[ConfiguracionPaisUpdate]    Script Date: 16/10/2017 13:35:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

-------------------------------------------------------------------------------------------------

---ROLLBACK
 
ALTER PROCEDURE [dbo].[ConfiguracionPaisGet] 
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

----------------------------------------------------------------------------------------

--- ROLLBACK

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeUpdate] 
	@ConfiguracionOfertasHomeID int,
	@ConfiguracionPaisID int,
	@CampaniaID int,
	@DesktopOrden int,
	@MobileOrden int,
	@DesktopImagenFondo varchar(250),
	@MobileImagenFondo varchar(250),
	@DesktopTitulo varchar(250),
	@MobileTitulo varchar(250),
	@DesktopSubTitulo varchar(250),
	@MobileSubTitulo varchar(250),
	@DesktopTipoPresentacion int,
	@MobileTipoPresentacion int,
	@DesktopTipoEstrategia varchar(250),
	@MobileTipoEstrategia varchar(250),
	@DesktopCantidadProductos int,
	@MobileCantidadProductos int,
	@DesktopActivo bit,
	@MobileActivo bit,
	@UrlSeccion varchar(250)
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO ConfiguracionOfertasHome (ConfiguracionPaisID,
				CampaniaID,
				DesktopOrden,
				MobileOrden,
				DesktopImagenFondo,
				MobileImagenFondo,
				DesktopTitulo,
				MobileTitulo,
				DesktopSubTitulo,
				MobileSubTitulo,
				DesktopTipoPresentacion,
				MobileTipoPresentacion,
				DesktopTipoEstrategia,
				MobileTipoEstrategia,
				DesktopCantidadProductos,
				MobileCantidadProductos,
				DesktopActivo,
				MobileActivo,
				UrlSeccion)
		VALUES (@ConfiguracionPaisID,
				@CampaniaID,
				@DesktopOrden,
				@MobileOrden,
				@DesktopImagenFondo,
				@MobileImagenFondo,
				@DesktopTitulo,
				@MobileTitulo,
				@DesktopSubTitulo,
				@MobileSubTitulo,
				@DesktopTipoPresentacion,
				@MobileTipoPresentacion,
				@DesktopTipoEstrategia,
				@MobileTipoEstrategia,
				@DesktopCantidadProductos,
				@MobileCantidadProductos,
				@DesktopActivo,
				@MobileActivo,
				@UrlSeccion);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO