---------------------------------------------------------------------
-- CREACION DE CAMPOS DE ORDEN MOBILE (MobileOrden, MobileOrdenBPT) 
-- PARA TABLA dbo.ConfiguracionPais 
-- BPT 353
-- 16/10/2017
---------------------------------------------------------------------

ALTER TABLE dbo.ConfiguracionPais ADD MobileOrden int NULL, MobileOrdenBPT INT NULL ;  
GO
ALTER TABLE dbo.ConfiguracionPais ADD CONSTRAINT MobileOrden_def DEFAULT 0 FOR MobileOrden;  
GO 
ALTER TABLE dbo.ConfiguracionPais ADD CONSTRAINT MobileOrdenBPT_def DEFAULT 0 FOR MobileOrdenBPT;  
GO 

UPDATE configuracionpais
SET	MobileOrden = 0,
	MobileOrdenBPT = 0



 --------------------------------------------------------------------------------------------------------------

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
		OrdenBpt,
		MobileOrden, 
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock)
	WHERE 
		P.TienePerfil = @TienePerfil
END


----------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------

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
		OrdenBpt,
		MobileOrden, 
		MobileOrdenBPT
	FROM ConfiguracionPais AS P with(nolock) 
	WHERE 
		P.ConfiguracionPaisID = @ConfiguracionPaisID
END



-------------- OFERTAS HOME ------------------------------------------------------------------

/****** Object:  StoredProcedure [dbo].[ConfiguracionOfertasHomeUpdate]    Script Date: 19/10/2017 11:05:04 ******/
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
	@UrlSeccion varchar(250),
	@DesktopOrdenBpt int,
	@MobileOrdenBpt int
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
				UrlSeccion,
				DesktopOrdenBpt,
				MobileOrdenBpt)
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
				@UrlSeccion,
				@DesktopOrdenBpt,
				@MobileOrdenBpt);
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
			UrlSeccion = @UrlSeccion,
			DesktopOrdenBpt = @DesktopOrdenBpt,
			MobileOrdenBpt = @MobileOrdenBpt
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END

GO



