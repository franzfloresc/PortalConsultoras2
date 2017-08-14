-- SCRIPTS NECESARIOS PARA CONFIGURACION PAIS PERFIL

-- Agregar colummna para las palancas 
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT default 'FALSE';
		--DROP COLUMN TienePerfil 
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Orden int NOT NULL DEFAULT(0);

	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);

	ALTER TABLE ConfiguracionPais
	ADD Color VARCHAR(255);
END
GO
-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
	INSERT INTO [dbo].[Permiso]
           ([PermisoID]
           ,[Descripcion]
           ,[IdPadre]
           ,[OrdenItem]
           ,[UrlItem]
           ,[PaginaNueva]
           ,[Posicion]
           ,[UrlImagen]
           ,[EsSoloImagen]
           ,[EsMenuEspecial]
           ,[EsServicios]
           ,[EsPrincipal]
           ,[Codigo])
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO

--- STORES NECESARIO 

ALTER PROCEDURE [dbo].[ConfiguracionPaisList]
	@TienePerfil BIT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.TienePerfil = @TienePerfil
END
GO

ALTER PROCEDURE [dbo].[ConfiguracionPaisGet] 
	@ConfiguracionPaisID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionPais AS P WHERE 
	P.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

ALTER PROCEDURE [dbo].[ConfiguracionPaisUpdate] 
	@ConfiguracionPaisID int,
	@Excluyente bit,
	@Descripcion varchar(250),
	@Estado bit,
	@DesdeCampania int,
	@MobileTituloMenu varchar(250),
	@DesktopTituloMenu varchar(250),
	@Logo varchar(250),
	@Color varchar(250),
	@Orden int,
	@DesktopTituloBanner varchar(250),
	@MobileTituloBanner varchar(250),
	@DesktopSubTituloBanner varchar(250),
	@MobileSubTituloBanner varchar(250)
AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (Excluyente, Descripcion, Estado, DesdeCampania, MobileTituloMenu, DesktopTituloMenu, Logo, Color, Orden, 
								DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner, MobileSubTituloBanner)
		VALUES (@Excluyente, @Descripcion, @Estado, @DesdeCampania, @MobileTituloMenu, @DesktopTituloMenu, @Logo, @Color, @Orden, 
								@DesktopTituloBanner, @MobileTituloBanner, @DesktopSubTituloBanner, @MobileSubTituloBanner);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
			Excluyente = @Excluyente, 
			Descripcion = @Descripcion, 
			Estado = @Estado,
			DesdeCampania = @DesdeCampania, 
			MobileTituloMenu = @MobileTituloMenu, 
			DesktopTituloMenu = @DesktopTituloMenu,
			Logo = @Logo, 
			Color = @Color, 
			Orden = @Orden, 
			DesktopTituloBanner = @DesktopTituloBanner, 
			MobileTituloBanner = @MobileTituloBanner,
			DesktopSubTituloBanner = @DesktopSubTituloBanner, 
			MobileSubTituloBanner = @MobileSubTituloBanner
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID;
		set @insertedId = @ConfiguracionPaisID;
	END
END


----- 

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[ConfiguracionOfertasHome](
	[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
	[ConfiguracionPaisID] [int] NOT NULL,
	[CampaniaID] [int] NOT NULL,
	[DesktopOrden] [int] NOT NULL,
	[MobileOrden] [int] NOT NULL,
	[DesktopImagenFondo] [varchar](250) NULL,
	[MobileImagenFondo] [varchar](250) NULL,
	[DesktopTitulo] [varchar](250) NULL,
	[MobileTitulo] [varchar](250) NULL,
	[DesktopSubTitulo] [varchar](250) NULL,
	[MobileSubTitulo] [varchar](250) NULL,
	[DesktopTipoPresentacion] [int] NOT NULL,
	[MobileTipoPresentacion] [int] NOT NULL,
	[DesktopTipoEstrategia] [varchar](250) NULL,
	[MobileTipoEstrategia] [varchar](250) NULL,
	[DesktopCantidadProductos] [int] NOT NULL,
	[MobileCantidadProductos] [int] NOT NULL,
	[DesktopActivo] [bit] NOT NULL,
	[MobileActivo] [bit] NOT NULL
) ON [DATA]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

GO



CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeList]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome;
END
GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeGet] 
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM ConfiguracionOfertasHome AS P WHERE 
	P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
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
	@MobileActivo bit
	AS 
BEGIN
SET NOCOUNT ON
DECLARE @InsertedId int = 0;
IF(@ConfiguracionPaisID = 0)
	BEGIN
		INSERT INTO ConfiguracionPais (ConfiguracionPaisID,
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
				MobileActivo)
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
				@MobileActivo);
		set @insertedId = scope_identity();
	END
ELSE 
	BEGIN
		UPDATE ConfiguracionPais SET
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
			MobileActivo = @MobileActivo
		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID;
		set @insertedId = @ConfiguracionPaisID;
	END
END
